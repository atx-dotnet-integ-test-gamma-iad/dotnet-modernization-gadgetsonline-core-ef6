# Next Steps

## Issues resolved
- Transformed GadgetsOnline.csproj to net8.0

## Summary

The solution build output contains no errors for the transformed project (`GadgetsOnline/GadgetsOnline.csproj`). This indicates the migration to cross-platform .NET has completed without any compilation issues.

## Validation Steps

### 1. Restore Dependencies

Run the following command from the solution root to ensure all NuGet packages are properly restored:

```bash
dotnet restore
```

Review the output for any warnings related to package compatibility or deprecated packages targeting older frameworks.

### 2. Build the Project

Perform a full build to confirm the error-free state is consistent across configurations:

```bash
dotnet build --configuration Debug
dotnet build --configuration Release
```

### 3. Review Target Framework

Open `GadgetsOnline/GadgetsOnline.csproj` and confirm the `<TargetFramework>` element is set to a currently supported version, for example:

```xml
<TargetFramework>net8.0</TargetFramework>
```

If it is targeting an older version such as `net5.0` or `net6.0`, consider updating to `net8.0` as those versions are out of support.

### 4. Run Unit Tests

If a test project exists within the solution, execute the tests to verify runtime behavior has not regressed:

```bash
dotnet test
```

Review any failing tests carefully, as they may indicate behavioral differences between the legacy .NET Framework APIs and the cross-platform .NET equivalents.

### 5. Verify Runtime Behavior

Start the application locally and manually exercise the core functionality:

```bash
dotnet run --project GadgetsOnline/GadgetsOnline.csproj
```

Pay particular attention to the following areas that commonly surface issues at runtime rather than compile time:

- **Configuration**: Ensure `appsettings.json` is present and replaces any legacy `Web.config` or `App.config` values correctly.
- **Database connectivity**: Verify connection strings are correctly defined and that any Entity Framework migrations run without errors using `dotnet ef database update`.
- **Authentication and Authorization**: If the project uses ASP.NET Identity or cookie-based auth, confirm middleware is registered correctly in `Program.cs` or `Startup.cs`.
- **Static files and routing**: Confirm that static assets are served correctly and that all routes resolve as expected.

### 6. Check for Removed or Changed APIs

Even without build errors, some APIs behave differently on cross-platform .NET. Review the code for usage of the following:

- `System.Web` references (these are not available on cross-platform .NET and should have been replaced during transformation)
- `HttpContext.Current` (replaced by dependency-injected `IHttpContextAccessor`)
- `ConfigurationManager` (replaced by `Microsoft.Extensions.Configuration`)
- Windows-specific APIs such as the registry or certain cryptography providers

Use the [.NET Upgrade Assistant compatibility analyzer](https://learn.microsoft.com/en-us/dotnet/core/porting/upgrade-assistant-overview) to scan for any remaining compatibility concerns.

### 7. Review Warnings

Even if there are no errors, build warnings can indicate deprecated APIs or potential issues:

```bash
dotnet build --configuration Release 2>&1 | grep -i warning
```

Address any warnings related to nullable reference types, obsolete members, or platform compatibility attributes.

## Deployment

Once the application has been validated locally, publish a release build using:

```bash
dotnet publish --configuration Release --output ./publish
```

Verify the contents of the `./publish` directory and confirm all required assets, configuration files, and dependencies are present before deploying to the target environment.