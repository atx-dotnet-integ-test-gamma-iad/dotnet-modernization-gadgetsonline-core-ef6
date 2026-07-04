# Next Steps

## Issues resolved
- Transformed GadgetsOnline.csproj to net8.0

## Summary

The solution has no build errors following the transformation. The project `GadgetsOnline/GadgetsOnline.csproj` compiled successfully, which indicates the migration to cross-platform .NET was completed without introducing any breaking changes at the build level.

## Validation Steps

### 1. Review the Target Framework

Open `GadgetsOnline/GadgetsOnline.csproj` and confirm the target framework is set to a supported cross-platform version:

```xml
<TargetFramework>net8.0</TargetFramework>
```

If it is targeting `net8.0` or `net6.0`, the project is on a supported long-term release. If it is targeting something older such as `net5.0` or `netcoreapp3.1`, consider upgrading to `net8.0` as those versions are out of support.

### 2. Restore and Build from the Command Line

Run the following commands from the solution root to confirm a clean restore and build outside of any IDE:

```bash
dotnet restore
dotnet build --configuration Release
```

Ensure there are no warnings that could indicate deprecated APIs or compatibility issues.

### 3. Run the Test Suite

If the solution contains test projects, execute them to verify runtime behavior has not changed:

```bash
dotnet test --configuration Release
```

Review any failing tests carefully, as they may indicate behavioral differences between the legacy .NET Framework runtime and the new cross-platform .NET runtime.

### 4. Check for Runtime-Only Issues

Some issues do not surface at build time but appear at runtime. Start the application and manually exercise the following areas, which are common sources of cross-platform runtime issues:

- **File system paths**: Ensure no hardcoded backslash (`\`) path separators are used. Replace with `Path.Combine` or forward slashes where appropriate.
- **Configuration**: Verify that `appsettings.json` or equivalent configuration files are present and being read correctly, replacing any legacy `web.config` or `app.config` reliance where applicable.
- **Database connections**: Confirm connection strings are valid and the appropriate NuGet driver packages are referenced.
- **Authentication and session handling**: If the application uses ASP.NET Identity or session state, verify these are configured correctly in `Program.cs` or `Startup.cs`.

### 5. Review NuGet Package Compatibility

Run the following command to check for any outdated or deprecated packages:

```bash
dotnet list package --outdated
```

Also run:

```bash
dotnet list package --vulnerable
```

Update any packages flagged as vulnerable or incompatible with the current target framework.

### 6. Test on the Target Operating Systems

Since the goal is cross-platform support, run the application on each intended operating system (e.g., Windows, Linux, macOS) to catch any platform-specific issues that would not appear in a single-environment test.

### 7. Publish the Application

Once validation is complete, publish the application using the following command, adjusting the runtime identifier (`-r`) as needed:

```bash
dotnet publish --configuration Release --output ./publish
```

For a self-contained deployment:

```bash
dotnet publish --configuration Release --self-contained true -r linux-x64 --output ./publish
```

Review the contents of the `./publish` directory to confirm all required files, static assets, and configuration files are present before deploying to the target environment.