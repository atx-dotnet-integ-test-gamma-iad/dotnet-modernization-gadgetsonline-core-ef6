# Next Steps

## Issues resolved
- Transformed GadgetsOnline.csproj to net8.0

## Summary

The transformation appears to have completed successfully. No build errors were detected across any of the projects in the solution, including `GadgetsOnline/GadgetsOnline.csproj`.

## Validation Steps

### 1. Restore Dependencies

Run the following command from the root of the solution to ensure all NuGet packages are properly restored:

```bash
dotnet restore
```

Review the output for any warnings related to missing packages or version conflicts.

### 2. Build the Solution

Perform a full build to confirm the absence of errors in a clean build environment:

```bash
dotnet build --configuration Release
```

Address any warnings that surface during this step, particularly those related to deprecated APIs or nullable reference types, as these can indicate areas that may cause runtime issues.

### 3. Review Target Framework

Open `GadgetsOnline/GadgetsOnline.csproj` and confirm the `<TargetFramework>` element is set to a currently supported version of .NET (e.g., `net8.0`). If it is targeting an older or end-of-life version such as `net5.0` or `net6.0`, consider updating it:

```xml
<TargetFramework>net8.0</TargetFramework>
```

After changing the target framework, re-run `dotnet restore` and `dotnet build`.

### 4. Run the Application Locally

Start the application locally to verify it runs as expected:

```bash
dotnet run --project GadgetsOnline/GadgetsOnline.csproj --configuration Release
```

Navigate through the application and exercise the primary workflows to check for runtime exceptions or unexpected behavior.

### 5. Check for Removed or Changed APIs

Even without build errors, some APIs behave differently in cross-platform .NET compared to .NET Framework. Pay particular attention to:

- **`System.Web` dependencies**: These are not available in cross-platform .NET. Confirm that any previous reliance on `System.Web` (e.g., `HttpContext`, `HttpRequest`) has been fully replaced with `Microsoft.AspNetCore` equivalents.
- **Configuration**: Ensure `web.config`-based configuration has been replaced with `appsettings.json` and the `IConfiguration` system.
- **Session and Authentication**: Verify that session management and authentication middleware are correctly configured in `Program.cs` or `Startup.cs`.

### 6. Execute Existing Tests

If the solution contains test projects, run them to validate core functionality:

```bash
dotnet test --configuration Release
```

Review any failing tests and determine whether the failures are due to the migration or pre-existing issues.

### 7. Verify Static Files and wwwroot

Confirm that static assets (CSS, JavaScript, images) have been placed under the `wwwroot` folder, as this is required for ASP.NET Core to serve them correctly. Check that the project file includes:

```xml
<ItemGroup>
  <Content Include="wwwroot\**" />
</ItemGroup>
```

### 8. Review Logging and Error Handling

Check that logging is configured using the built-in `Microsoft.Extensions.Logging` abstractions and that any legacy `log4net` or `System.Diagnostics.Trace` usage has been reviewed for compatibility or replaced accordingly.

### 9. Validate Database Connectivity

If the application uses a database, confirm that the connection strings in `appsettings.json` are correct and that Entity Framework Core (if applicable) migrations are up to date:

```bash
dotnet ef database update --project GadgetsOnline/GadgetsOnline.csproj
```

### 10. Test on Target Operating System

If the intent of the migration is to run on Linux or macOS, ensure the application is tested on that platform specifically. Pay attention to:

- **File path casing**: Linux file systems are case-sensitive.
- **Path separators**: Use `Path.Combine` rather than hardcoded backslashes.
- **Windows-specific APIs**: Confirm none are in use.