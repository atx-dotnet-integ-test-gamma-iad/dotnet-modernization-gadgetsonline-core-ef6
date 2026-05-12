# Next Steps

## Issues resolved
- Transformed GadgetsOnline.csproj to net8.0

## Summary

The transformation appears to have completed successfully. No build errors were detected in any of the projects within the solution, including `GadgetsOnline/GadgetsOnline.csproj`.

## Validation Steps

### 1. Restore Dependencies

Run the following command from the root of the solution to ensure all NuGet packages are restored correctly:

```bash
dotnet restore
```

Review the output for any warnings related to missing packages or version conflicts and resolve them before proceeding.

### 2. Build the Solution

Perform a full build to confirm there are no compilation issues:

```bash
dotnet build --configuration Release
```

Confirm that the build completes with zero errors and review any warnings that may indicate deprecated APIs or compatibility concerns.

### 3. Review Target Framework

Open `GadgetsOnline/GadgetsOnline.csproj` and verify that the `<TargetFramework>` element is set to the intended cross-platform .NET version, for example:

```xml
<TargetFramework>net8.0</TargetFramework>
```

If the project is a web application, confirm it references `Microsoft.NET.Sdk.Web`:

```xml
<Project Sdk="Microsoft.NET.Sdk.Web">
```

### 4. Run Unit Tests

If the solution contains test projects, execute them to verify that existing functionality behaves as expected:

```bash
dotnet test --configuration Release
```

Review any failing tests and determine whether they are caused by behavioral differences between the legacy .NET Framework and the new .NET runtime.

### 5. Check for Removed or Changed APIs

Some APIs available in .NET Framework are not present or have changed in cross-platform .NET. Use the [.NET Upgrade Assistant compatibility analyzer](https://learn.microsoft.com/en-us/dotnet/core/porting/upgrade-assistant-overview) or the `Microsoft.DotNet.PlatformAbstractions` compatibility package to identify any runtime issues that would not surface as build errors.

Pay particular attention to:

- `System.Web` usages, which are not available in cross-platform .NET
- Windows-specific APIs such as the registry, WCF server-side components, or `System.Drawing` on non-Windows platforms
- Any third-party libraries that may still target .NET Framework only

### 6. Run the Application Locally

Start the application and exercise its primary workflows manually:

```bash
dotnet run --project GadgetsOnline/GadgetsOnline.csproj --configuration Release
```

Verify that all major routes, pages, or endpoints respond correctly and that no runtime exceptions are thrown.

### 7. Review Configuration Files

Ensure that configuration has been correctly migrated from `Web.config` or `App.config` to `appsettings.json` and that environment-specific settings are handled using the appropriate `IConfiguration` abstractions.

### 8. Validate Database Connectivity

If the application uses a database, confirm that connection strings in `appsettings.json` are correct and that any Entity Framework migrations or database initialization logic executes without errors:

```bash
dotnet ef database update --project GadgetsOnline/GadgetsOnline.csproj
```

### 9. Deploy to Target Environment

Once all of the above steps pass without errors:

1. Publish the application using the appropriate runtime identifier for your target environment:

```bash
dotnet publish --configuration Release --runtime linux-x64 --self-contained false
```

2. Copy the output from the `publish` folder to the target server or hosting environment.
3. Confirm that the correct .NET runtime version is installed on the target machine.
4. Start the application and perform a final smoke test against the deployed instance.